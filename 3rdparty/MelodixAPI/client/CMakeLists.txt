cmake_minimum_required(VERSION 3.2)

project(QtMelodixAPI)

find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Network Gui)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

add_library(${PROJECT_NAME}
  MDBanner_200_response.h
  MDBanner_200_response_banners_inner.h
  MDCellphoneLogin_200_response.h
  MDCellphoneLogin_200_response_account.h
  MDCellphoneLogin_200_response_bindings_inner.h
  MDCellphoneLogin_200_response_profile.h
  MDCellphoneLogin_200_response_profile_avatarDetail.h
  MDCheckMusic_200_response.h
  MDDailySongRecommend_200_response.h
  MDDailySongRecommend_200_response_data.h
  MDDailySongRecommend_200_response_data_dailySongs_inner.h
  MDDailySongRecommend_200_response_data_dailySongs_inner_ar_inner.h
  MDGetAccountInfo_200_response.h
  MDGetAccountInfo_200_response_profile.h
  MDGetArtistAlbum_200_response.h
  MDGetArtistAlbum_200_response_artist.h
  MDGetArtistAlbum_200_response_hotAlbums_inner.h
  MDGetArtistAlbum_200_response_hotAlbums_inner_artist.h
  MDGetArtistAlbum_200_response_hotAlbums_inner_artists_inner.h
  MDGetArtistDetail_200_response.h
  MDGetArtistDetail_200_response_data.h
  MDGetArtistDetail_200_response_data_artist.h
  MDGetArtistDetail_200_response_data_identify.h
  MDGetArtistDetail_200_response_data_user.h
  MDGetArtistDetail_200_response_data_vipRights.h
  MDGetArtistDetail_200_response_data_vipRights_rightsInfoDetailDtoList_inner.h
  MDGetArtistSingle_200_response.h
  MDGetArtistSingle_200_response_songs_inner.h
  MDGetArtistSublist_200_response.h
  MDGetArtistSublist_200_response_data_inner.h
  MDGetLikeSongId_200_response.h
  MDGetLoginStatus_200_response.h
  MDGetLoginStatus_200_response_data.h
  MDGetLoginStatus_200_response_data_account.h
  MDGetLoginStatus_200_response_data_profile.h
  MDGetLyric_200_response.h
  MDGetLyric_200_response_lrc.h
  MDGetMvDetail_200_response.h
  MDGetMvDetail_200_response_data.h
  MDGetMvDetail_200_response_data_artists_inner.h
  MDGetMvDetail_200_response_data_brs_inner.h
  MDGetPlaylistDetail_200_response.h
  MDGetPlaylistDetail_200_response_playlist.h
  MDGetPlaylistDetail_200_response_playlist_creator.h
  MDGetPlaylistTrackAll_200_response.h
  MDGetPlaylistTrackAll_200_response_songs_inner.h
  MDGetPlaylistTrackAll_200_response_songs_inner_al.h
  MDGetPurchasedAlbum_200_response.h
  MDGetPurchasedAlbum_200_response_paidAlbums_inner.h
  MDGetQrKey_200_response.h
  MDGetQrKey_200_response_data.h
  MDGetRecommendResource_200_response.h
  MDGetRecommendResource_200_response_recommend_inner.h
  MDGetRecommendedNewSongs_200_response.h
  MDGetRecommendedNewSongs_200_response_result_inner.h
  MDGetRecommendedNewSongs_200_response_result_inner_song.h
  MDGetRecommendedNewSongs_200_response_result_inner_song_album.h
  MDGetRecommendedNewSongs_200_response_result_inner_song_artists_inner.h
  MDGetRecommendedPlaylist_200_response.h
  MDGetRecommendedPlaylist_200_response_result_inner.h
  MDGetSongDetail_200_response.h
  MDGetSongDetail_200_response_songs_inner.h
  MDGetSongDetail_200_response_songs_inner_ar_inner.h
  MDGetSongUrl_200_response.h
  MDGetSongUrl_200_response_data_inner.h
  MDGetTopArtists_200_response.h
  MDGetTopArtists_200_response_artists_inner.h
  MDGetTopPlaylist_200_response.h
  MDGetTopPlaylist_200_response_playlists_inner.h
  MDGetTopPlaylist_200_response_playlists_inner_creator.h
  MDGetTopPlaylist_200_response_playlists_inner_creator_avatarDetail.h
  MDGetTopPlaylist_200_response_playlists_inner_creator_experts.h
  MDGetUserDetail_200_response.h
  MDGetUserDetail_200_response_bindings_inner.h
  MDGetUserDetail_200_response_identify.h
  MDGetUserDetail_200_response_products_inner.h
  MDGetUserDetail_200_response_profile.h
  MDGetUserDetail_200_response_profileVillageInfo.h
  MDGetUserDetail_200_response_profile_allAuthTypes_inner.h
  MDGetUserDetail_200_response_profile_avatarDetail.h
  MDGetUserDetail_200_response_profile_mainAuthType.h
  MDGetUserDetail_200_response_profile_privacyItemUnlimit.h
  MDGetUserDetail_200_response_userPoint.h
  MDGetUserPlaylist_200_response.h
  MDGetUserPlaylist_200_response_playlist_inner.h
  MDGetUserPlaylist_200_response_playlist_inner_creator.h
  MDLikeMusic_200_response.h
  MDQrCheck_200_response.h
  MDQrCreate_200_response.h
  MDQrCreate_200_response_data.h
  MDSearch_200_response.h
  MDSearch_200_response_result.h
  MDSearch_200_response_result_songs_inner.h
  MDSearch_200_response_result_songs_inner_al.h
  MDSearch_200_response_result_songs_inner_ar_inner.h
  MDVerifyCaptcha_200_response.h
  MDClientApi.h
  MDHelpers.h
  MDHttpRequest.h
  MDObject.h
  MDEnum.h
  MDHttpFileElement.h
  MDServerConfiguration.h
  MDServerVariable.h
  MDOauth.h
  MDBanner_200_response.cpp
  MDBanner_200_response_banners_inner.cpp
  MDCellphoneLogin_200_response.cpp
  MDCellphoneLogin_200_response_account.cpp
  MDCellphoneLogin_200_response_bindings_inner.cpp
  MDCellphoneLogin_200_response_profile.cpp
  MDCellphoneLogin_200_response_profile_avatarDetail.cpp
  MDCheckMusic_200_response.cpp
  MDDailySongRecommend_200_response.cpp
  MDDailySongRecommend_200_response_data.cpp
  MDDailySongRecommend_200_response_data_dailySongs_inner.cpp
  MDDailySongRecommend_200_response_data_dailySongs_inner_ar_inner.cpp
  MDGetAccountInfo_200_response.cpp
  MDGetAccountInfo_200_response_profile.cpp
  MDGetArtistAlbum_200_response.cpp
  MDGetArtistAlbum_200_response_artist.cpp
  MDGetArtistAlbum_200_response_hotAlbums_inner.cpp
  MDGetArtistAlbum_200_response_hotAlbums_inner_artist.cpp
  MDGetArtistAlbum_200_response_hotAlbums_inner_artists_inner.cpp
  MDGetArtistDetail_200_response.cpp
  MDGetArtistDetail_200_response_data.cpp
  MDGetArtistDetail_200_response_data_artist.cpp
  MDGetArtistDetail_200_response_data_identify.cpp
  MDGetArtistDetail_200_response_data_user.cpp
  MDGetArtistDetail_200_response_data_vipRights.cpp
  MDGetArtistDetail_200_response_data_vipRights_rightsInfoDetailDtoList_inner.cpp
  MDGetArtistSingle_200_response.cpp
  MDGetArtistSingle_200_response_songs_inner.cpp
  MDGetArtistSublist_200_response.cpp
  MDGetArtistSublist_200_response_data_inner.cpp
  MDGetLikeSongId_200_response.cpp
  MDGetLoginStatus_200_response.cpp
  MDGetLoginStatus_200_response_data.cpp
  MDGetLoginStatus_200_response_data_account.cpp
  MDGetLoginStatus_200_response_data_profile.cpp
  MDGetLyric_200_response.cpp
  MDGetLyric_200_response_lrc.cpp
  MDGetMvDetail_200_response.cpp
  MDGetMvDetail_200_response_data.cpp
  MDGetMvDetail_200_response_data_artists_inner.cpp
  MDGetMvDetail_200_response_data_brs_inner.cpp
  MDGetPlaylistDetail_200_response.cpp
  MDGetPlaylistDetail_200_response_playlist.cpp
  MDGetPlaylistDetail_200_response_playlist_creator.cpp
  MDGetPlaylistTrackAll_200_response.cpp
  MDGetPlaylistTrackAll_200_response_songs_inner.cpp
  MDGetPlaylistTrackAll_200_response_songs_inner_al.cpp
  MDGetPurchasedAlbum_200_response.cpp
  MDGetPurchasedAlbum_200_response_paidAlbums_inner.cpp
  MDGetQrKey_200_response.cpp
  MDGetQrKey_200_response_data.cpp
  MDGetRecommendResource_200_response.cpp
  MDGetRecommendResource_200_response_recommend_inner.cpp
  MDGetRecommendedNewSongs_200_response.cpp
  MDGetRecommendedNewSongs_200_response_result_inner.cpp
  MDGetRecommendedNewSongs_200_response_result_inner_song.cpp
  MDGetRecommendedNewSongs_200_response_result_inner_song_album.cpp
  MDGetRecommendedNewSongs_200_response_result_inner_song_artists_inner.cpp
  MDGetRecommendedPlaylist_200_response.cpp
  MDGetRecommendedPlaylist_200_response_result_inner.cpp
  MDGetSongDetail_200_response.cpp
  MDGetSongDetail_200_response_songs_inner.cpp
  MDGetSongDetail_200_response_songs_inner_ar_inner.cpp
  MDGetSongUrl_200_response.cpp
  MDGetSongUrl_200_response_data_inner.cpp
  MDGetTopArtists_200_response.cpp
  MDGetTopArtists_200_response_artists_inner.cpp
  MDGetTopPlaylist_200_response.cpp
  MDGetTopPlaylist_200_response_playlists_inner.cpp
  MDGetTopPlaylist_200_response_playlists_inner_creator.cpp
  MDGetTopPlaylist_200_response_playlists_inner_creator_avatarDetail.cpp
  MDGetTopPlaylist_200_response_playlists_inner_creator_experts.cpp
  MDGetUserDetail_200_response.cpp
  MDGetUserDetail_200_response_bindings_inner.cpp
  MDGetUserDetail_200_response_identify.cpp
  MDGetUserDetail_200_response_products_inner.cpp
  MDGetUserDetail_200_response_profile.cpp
  MDGetUserDetail_200_response_profileVillageInfo.cpp
  MDGetUserDetail_200_response_profile_allAuthTypes_inner.cpp
  MDGetUserDetail_200_response_profile_avatarDetail.cpp
  MDGetUserDetail_200_response_profile_mainAuthType.cpp
  MDGetUserDetail_200_response_profile_privacyItemUnlimit.cpp
  MDGetUserDetail_200_response_userPoint.cpp
  MDGetUserPlaylist_200_response.cpp
  MDGetUserPlaylist_200_response_playlist_inner.cpp
  MDGetUserPlaylist_200_response_playlist_inner_creator.cpp
  MDLikeMusic_200_response.cpp
  MDQrCheck_200_response.cpp
  MDQrCreate_200_response.cpp
  MDQrCreate_200_response_data.cpp
  MDSearch_200_response.cpp
  MDSearch_200_response_result.cpp
  MDSearch_200_response_result_songs_inner.cpp
  MDSearch_200_response_result_songs_inner_al.cpp
  MDSearch_200_response_result_songs_inner_ar_inner.cpp
  MDVerifyCaptcha_200_response.cpp
  MDClientApi.cpp
  MDHelpers.cpp
  MDHttpRequest.cpp
  MDHttpFileElement.cpp
  MDOauth.cpp
  )

target_include_directories(${PROJECT_NAME}
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

target_link_libraries(${PROJECT_NAME}
    PUBLIC
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Network
        Qt${QT_VERSION_MAJOR}::Gui

)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
)

install(
    TARGETS ${PROJECT_NAME}
    EXPORT ${PROJECT_NAME}Targets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}"
)

install(
    FILES ${HEADER_FILES}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
)

install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

install(
    EXPORT ${PROJECT_NAME}Targets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
