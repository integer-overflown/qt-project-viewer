#ifndef QMLTEST_AUTHENTICATOR_H
#define QMLTEST_AUTHENTICATOR_H
#include <QObject>
#include <QNetworkReply>
#include <QUrl>
#include <QtQml>
#include <private/Credentials.hpp>

class Authenticator : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    Q_INVOKABLE void verify(QString login, QString password);
signals:
    void submitted(QString token);
    void rejected();
    void error(QString errorString);
private:
    const QUrl address { api::login };
};

#endif // QMLTEST_AUTHENTICATOR_H
