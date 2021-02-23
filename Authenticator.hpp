#ifndef QMLTEST_AUTHENTICATOR_H
#define QMLTEST_AUTHENTICATOR_H
#include <QObject>
#include <QNetworkReply>
#include <QUrl>
#include <QtQml>

class Authenticator : public QObject
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
private:
    QScopedPointer<QNetworkAccessManager> manager;
    QNetworkRequest request;
};

#endif // QMLTEST_AUTHENTICATOR_H
