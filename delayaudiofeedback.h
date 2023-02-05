#ifndef DELAYAUDIOFEEDBACK_H
#define DELAYAUDIOFEEDBACK_H

#include <QObject>
#include <QString>

class DelayAudioFeedback : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString status READ status WRITE setStatus NOTIFY statusChanged)
public:
    Q_INVOKABLE void setStatus(const QString &currentStatus);
    QString status() const;
signals:
    void statusChanged();
private:
    QString dafStatus;
};

#endif // DELAYAUDIOFEEDBACK

