#include "delayaudiofeedback.h"
#include <QProcess>
#include <QCloseEvent>

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

void DelayAudioFeedback::startPulseAudio()
{
    QString program = "/usr/bin/pactl";
    QStringList arguments;
    arguments << "load-module" << "module-loopback" << "latency_msec=1";

    
    m_pulseProcessStart = new QProcess(this);
    m_pulseProcessStart->start(program, arguments);
}

void DelayAudioFeedback::stopPulseAudio()
{
    m_pulseProcessStart->deleteLater();
    QString program = "/usr/bin/pactl";
    QStringList arguments;
    arguments << "unload-module" << "module-loopback";

    
    m_pulseProcessStop = new QProcess(this);
    m_pulseProcessStop->start(program, arguments);
}