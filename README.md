# Digi Music

Digi Music是一个使用QML开发的在线音乐播放器，旨在为用户提供便捷的音乐播放体验。

## 功能特点

- 支持网易云账户登录
- 搜索音乐

## 安装和运行

1. 克隆项目到本地:

```bash
git clone https://github.com/student-ice/digimusic.git
```

2. 安装所需的依赖:

```bash
cd digimusic
sudo apt build-dep .
```

3. 编译：

```bash
cmake -B build
cmake --build build
```

4. 安装：

```bash
sudo make install
```

5. 打包:

```bash
sudo dpkg-buildpackage -us -uc
```

## 技术栈

- 前端：使用QML语言构建用户界面。
- 后端：使用[NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)

## 贡献

如果你对这个项目感兴趣，欢迎提交PR或者提出建议和问题。我会尽快回复和处理。

## 许可证

该项目基于GPL-3.0许可证。详情请参阅[LICENSE](./LICENSE)文件。

## 联系方式

如果你有任何问题或者建议，可以通过以下方式联系我：

- 邮箱：tonimayloneya@gmail.com
