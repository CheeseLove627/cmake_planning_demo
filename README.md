# cmake_planning_demo

一个用于演示 CMake 分目录组织、目标依赖（`target_link_libraries`）与头文件可见性（`PUBLIC/PRIVATE/INTERFACE`）的简单 C++ 工程。

## 环境要求

- macOS / Linux（本项目在 macOS 下创建）
- CMake >= 3.10
- 支持 C++17 的编译器（Clang / GCC）

## 项目结构

- `CMakeLists.txt`：顶层工程配置（设置 C++ 标准、输出目录、添加子目录）
- `src/`：源码与各子模块
  - `src/main.cpp`：可执行程序入口
  - `src/pnc_map/`：`pnc_map` 库
  - `src/process/`：`process` 库（依赖 `pnc_map`）
- `bin/`：可执行文件输出目录（由 `CMAKE_RUNTIME_OUTPUT_DIRECTORY` 指定）
- `build/`：构建目录（建议 out-of-source build）

## 构建（推荐 out-of-source）

按照命令行示范（在 `build/` 目录里生成构建文件）：

```bash
mkdir -p build
cd build
cmake ..
```

然后编译：

```bash
cmake --build . -j
```

如果你更习惯用 Makefile，也可以：

```bash
make -j
```

构建完成后，可执行文件会输出到：

- `bin/planning_main`

> 如果你看到的可执行文件名不同，请以顶层 `src/CMakeLists.txt` 中的 `add_executable(...)` 为准。

## 运行

```bash
cd bin
./planning_main
```

## 作为 SDK 导出（供二次开发）

本工程会安装并导出两个动态库目标：

- `planning::pnc_map`
- `planning::process`（PUBLIC 依赖 `planning::pnc_map`）

### 安装

在构建完成后执行安装（将头文件、动态库、CMake 包文件安装到 prefix）：

```bash
cmake -S . -B build
cmake --build build -j
cmake --install build --prefix <install_prefix>
```

安装后常见布局：

- `<install_prefix>/include/`：头文件（如 `process.h`、`pnc_map.h`）
- `<install_prefix>/lib/`：`.dylib/.so` 或 Windows 的 import lib `.lib`
- `<install_prefix>/bin/`：可执行文件与 Windows 的 `.dll`
- `<install_prefix>/lib/cmake/planning/`：`planningConfig.cmake`、`planningTargets.cmake`

### 第三方工程如何使用

第三方工程的 `CMakeLists.txt` 示例：

```cmake
cmake_minimum_required(VERSION 3.10)
project(consumer LANGUAGES CXX)

find_package(planning REQUIRED)

add_executable(consumer_app main.cpp)
target_link_libraries(consumer_app PRIVATE planning::process)
```

配置时告诉 CMake 去哪里找包：

```bash
cmake -S . -B build -DCMAKE_PREFIX_PATH=<install_prefix>
cmake --build build -j
```

> Windows/MSVC：运行时需要 `process.dll`、`pnc_map.dll` 与你的 exe 在同一目录（或加入 `PATH`）。

## 关于 `PUBLIC` / `PRIVATE` / `INTERFACE`

- `PRIVATE`：仅当前 target 编译时使用；不会传递给依赖它的 target
- `PUBLIC`：当前 target 编译时使用；也会传递给依赖它的 target
- `INTERFACE`：当前 target 编译时不使用；只传递给依赖它的 target（常用于 header-only 库）

例如在 `process` 模块中：

```cmake
target_include_directories(process PUBLIC ${Pnc_Map_Dir})
target_link_libraries(process PUBLIC pnc_map)
```

含义是：

- `process` 自己编译需要包含 `pnc_map` 的头文件目录；
- 任何链接了 `process` 的目标，也会自动获得这些 include 路径与链接依赖。

## 常见问题
