#include "delayaudiofeedback.h"
#include <QProcess>
#include <QCloseEvent>
#include <QFile> 

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
    arguments << "load-module" << "module-loopback" << "latency_msec=500";
    
    m_pulseProcessStart = new QProcess(this);
    m_pulseProcessStart->start(program, arguments);
}

void DelayAudioFeedback::stopPulseAudio()
{ 
    QString program = "/usr/bin/pactl";
    QStringList arguments;
    arguments << "unload-module" << "module-loopback";
    QProcess *process = new QProcess(this);
    process->start(program, arguments);
    process->waitForFinished();
    m_pulseProcessStart->kill();
}

bool DelayAudioFeedback::verifyPulseAudioInstallation(){
    if(QFile::exists("/usr/bin/pactl")) {
        return true;
    } else {
        return false;
    }
}