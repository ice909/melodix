import QtQuick 2.0
pragma Singleton

Item {
    property string node: "http://81.70.119.233:3000"

    // 发送http请求
    function request(method, rawUrl, callback) {
        const url = node + rawUrl;
        const xhr = new XMLHttpRequest();
        xhr.onreadystatechange = () => {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                switch (xhr.status) {
                case 200:
                    if (xhr.responseText.length > 0) {
                        callback(JSON.parse(xhr.responseText));
                    } else {
                        callback(null);
                    }
                    break;
                default:
                    console.log("network error", xhr.status);
                }
            }
        };
        xhr.open(method, url);
        xhr.send();
    }

    // 发送 get 请求
    function get(url, callback) {
        return request("GET", url, callback);
    }

    // 获取首页推荐歌单
    function getRecommendPlaylist(callback) {
        get("/personalized?limit=10", callback);
    }

    // 获取首页推荐新歌
    function getRecommendNewSongs(callback) {
        get("/personalized/newsong?limit=9", callback);
    }

    // 获取首页热门歌手
    function getHotSigner(callback) {
        get("/top/artists?limit=5", callback);
    }

    // 获取首页推荐MV
    function getRecommendMV(callback) {
        get("/personalized/mv", callback);
    }

}
