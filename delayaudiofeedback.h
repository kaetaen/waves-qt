#ifndef DELAYAUDIOFEEDBACK_H
#define DELAYAUDIOFEEDBACK_H

#include <QObject>
#include <QString>
#include <QProcess>

class DelayAudioFeedback : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
public:
    Q_INVOKABLE void setStatus(const QString &currentStatus);
    QString status() const;
    Q_INVOKABLE void startPulseAudio();
    Q_INVOKABLE void stopPulseAudio();
signals:
    void statusChanged();
private:
    QString dafStatus;
    QProcess* m_pulseProcessStart;
};

#endif // DELAYAUDIOFEEDBACK

