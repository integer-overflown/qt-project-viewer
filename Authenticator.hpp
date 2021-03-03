#ifndef QMLTEST_AUTHENTICATOR_H
#define QMLTEST_AUTHENTICATOR_H
#include <QObject>
#include <QNetworkReply>
#include <QUrl>
#include <QtQml>
#include <ApiClient.hpp>

class Authenticator : public QObject, public ApiClient
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON
public:
    explicit Authenticator(QObject* parent = nullptr);
    Q_INVOKABLE void verify(QString login, QString password);
signals:
    void submitted(QString token);
    void rejected();
    void error(QString errorString);
};

#endif // QMLTEST_AUTHENTICATOR_H
