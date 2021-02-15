#ifndef QMLTEST_AUTHENTICATOR_H
#define QMLTEST_AUTHENTICATOR_H
#include <QObject>
#include <QNetworkReply>
#include <QUrl>

class Authenticator : public QObject
{
    Q_OBJECT
public:
    Q_INVOKABLE void verify(QString login, QString password);
signals:
    void submitted(QString token);
    void rejected();
    void error(QString errorString);
private:
    static const QUrl address;
};

#endif // QMLTEST_AUTHENTICATOR_H
