# Melodix Music

Melodix Music is an online Music player, interface using QMl technology building, data from [NeteaseCloudMusicApi] (<https://github.com/Binaryify/NeteaseCloudMusicApi>)

## Functional characteristics

- Online Music playback: Melodix Music can play music online by obtaining data from the NeteaseCloudMusicApi.

- NetEase Cloud Account Login support: Users can log in to Melodix Music using their NetEase Cloud account in order to access their personal music library and playlists.

- Music Search: Melodix Music offers a convenient search function that allows users to quickly find the music they want to listen to. Users can search for music by song title.

- Playlist management: Melodix Music allows users to create and manage their own playlists. Users can add their favorite songs to a playlist and enjoy their music anytime, anywhere.

- Playback control: Melodix Music provides basic playback control functions such as play, pause, previous song, next song, and more. Users can easily control the progress and volume of music.

## Installation and operation

1. Clone the project locally:

    ```bash
    git clone https://github.com/student-ice/melodix.git
    ```

2. Dependencies required for installation:

    ```bash
    cd melodix
    sudo apt build-dep .
    ```

3. Compile:

    ```bash
    cmake -B build
    cmake --build build
    ```

4. install：

    ```bash
    sudo make install
    ```

5. Build package:

    ```bash
    sudo dpkg-buildpackage -us -uc
    ```

## Technology stack

- Front-end: Build the user interface using the QML language.
- Data sources: use [NeteaseCloudMusicApi] (<https://github.com/Binaryify/NeteaseCloudMusicApi>)

## Contribution

If you are interested in this project, feel free to submit PRs or provide suggestions and issues. I will respond and address them as soon as possible.

## License

This project is licensed under the GPL-3.0 License. For more details, please refer to the [LICENSE](./LICENSE) file.

## Contact

If you have any questions or suggestions, you can reach me through the following channels:

- Email: <tonimayloneya@gmail.com>
