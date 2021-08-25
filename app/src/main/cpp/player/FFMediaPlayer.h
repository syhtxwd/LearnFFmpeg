//
// Created by syh on 2021-08-24.
//

#ifndef LEANFFMPEG_FFMEDIAPLAYER_H
#define LEANFFMPEG_FFMEDIAPLAYER_H

#include <jni.h>
#include <decoder/VideoDecoder.h>
#include <decoder/AudioDecoder.h>
#include <render/audio/AudioRender.h>

#define JAVA_PLAYER_EVENT_CALLBACK_API_NAME "playerEventCallback"

#define MEDIA_PARAM_VIDEO_WIDTH         0x0001
#define MEDIA_PARAM_VIDEO_HEIGHT        0x0002
#define MEDIA_PARAM_VIDEO_DURATION      0x0003


class FFMediaPlayer {
public:
    FFMediaPlayer(){};
    ~FFMediaPlayer(){};

    void Init(JNIEnv *jniEnv, jobject obj, char *url, int renderType, jobject surface);

private:
    JavaVM *m_JavaVM = nullptr;
    jobject m_JavaObj = nullptr;

    VideoDecoder *m_VideoDecoder = nullptr;
    AudioDecoder *m_AudioDecoder = nullptr;

    //VideoRender *m_VideoRender = nullptr;
    AudioRender *m_AudioRender = nullptr;
};


#endif //LEANFFMPEG_FFMEDIAPLAYER_H