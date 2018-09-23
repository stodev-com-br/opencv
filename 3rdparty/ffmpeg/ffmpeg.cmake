# Binaries branch name: ffmpeg/master_20180918
# Binaries were created for OpenCV: e628fd7bce2b5d64c36b5bdc55a37c0ae78bc907
ocv_update(FFMPEG_BINARIES_COMMIT "c88df798e9dc3d63840f913714563a730245464a")
ocv_update(FFMPEG_FILE_HASH_BIN32 "48c95ce37d5aa6b15b3ad116e331ebc1")
ocv_update(FFMPEG_FILE_HASH_BIN64 "d33eca57ae1cfd6287b975b98125f7a3")
ocv_update(FFMPEG_FILE_HASH_CMAKE "5fd49e1b84e9f402ca155e27c92d2ce9")

function(download_win_ffmpeg script_var)
  set(${script_var} "" PARENT_SCOPE)

  set(ids BIN32 BIN64 CMAKE)
  set(name_BIN32 "opencv_ffmpeg.dll")
  set(name_BIN64 "opencv_ffmpeg_64.dll")
  set(name_CMAKE "ffmpeg_version.cmake")

  set(FFMPEG_DOWNLOAD_DIR "${OpenCV_BINARY_DIR}/3rdparty/ffmpeg")

  set(status TRUE)
  foreach(id ${ids})
    ocv_download(FILENAME ${name_${id}}
               HASH ${FFMPEG_FILE_HASH_${id}}
               URL
                 "$ENV{OPENCV_FFMPEG_URL}"
                 "${OPENCV_FFMPEG_URL}"
                 "https://raw.githubusercontent.com/opencv/opencv_3rdparty/${FFMPEG_BINARIES_COMMIT}/ffmpeg/"
               DESTINATION_DIR ${FFMPEG_DOWNLOAD_DIR}
               ID FFMPEG
               RELATIVE_URL
               STATUS res)
    if(NOT res)
      set(status FALSE)
    endif()
  endforeach()
  if(status)
    set(${script_var} "${FFMPEG_DOWNLOAD_DIR}/ffmpeg_version.cmake" PARENT_SCOPE)
  endif()
endfunction()

if(OPENCV_INSTALL_FFMPEG_DOWNLOAD_SCRIPT)
  configure_file("${CMAKE_CURRENT_LIST_DIR}/ffmpeg-download.ps1.in" "${CMAKE_BINARY_DIR}/win-install/ffmpeg-download.ps1" @ONLY)
  install(FILES "${CMAKE_BINARY_DIR}/win-install/ffmpeg-download.ps1" DESTINATION "." COMPONENT libs)
endif()
