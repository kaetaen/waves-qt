#include "delayaudiofeedback.h"

void DelayAudioFeedback::setStatus(const QString &currentStatus)
{
    if (currentStatus != dafStatus) {
        dafStatus = currentStatus;
        emit statusChanged();
    }
}

QString DelayAudioFeedback::status() const
{
    return dafStatus;
}
