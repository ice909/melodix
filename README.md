# Melodix 音乐

Melodix 音乐是一个在线音乐播放器，界面使用 QML 技术构建，数据来自 [NeteaseCloudMusicApi] (<https://github.com/Binaryify/NeteaseCloudMusicApi>)

## 功能特点

- 在线音乐播放：Melodix 音乐可以通过获取 NeteaseCloudMusicApi 的数据来播放在线音乐。

- 支持网易云账号登录：用户可以使用网易云账号登录 Melodix 音乐，以访问他们的个人音乐库和播放列表。

- 音乐搜索：Melodix 音乐提供了便捷的搜索功能，用户可以快速找到他们想听的音乐。用户可以通过歌曲标题搜索音乐。

- 播放列表管理：Melodix 音乐允许用户创建和管理自己的播放列表。用户可以将自己喜欢的歌曲添加到播放列表中，随时随地享受音乐。

- 播放控制：Melodix 音乐提供基本的播放控制功能，如播放、暂停、上一首、下一首等。用户可以轻松控制音乐的进度和音量。

## 安装和操作

1. 将项目克隆到本地：

   ```bash
   git clone https://github.com/student-ice/melodix.git
   ```

2. 安装所需依赖：

   ```bash
   cd melodix
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

5. 构建包：

   ```bash
   sudo dpkg-buildpackage -us -uc
   ```

## 技术栈

- 前端：使用 QML 语言构建用户界面。
- 数据来源：使用 [NeteaseCloudMusicApi] (<https://github.com/Binaryify/NeteaseCloudMusicApi>)

## 贡献

如果你对这个项目感兴趣，欢迎提交 PR 或提供建议和问题。我会尽快回复和处理。

## 许可证

此项目使用 GPL-3.0 许可证。更多详情请参阅 [LICENSE](./LICENSE) 文件。

## 联系方式

如果你有任何问题或建议，可以通过以下渠道联系我：

- 邮箱: <tonimayloneya@gmail.com>
