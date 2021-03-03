#ifndef QMLTEST_API_CLIENT_H
#define QMLTEST_API_CLIENT_H
#include <QNetworkAccessManager>

class ApiClient
{
protected:
    ApiClient(const QString&);
protected:
    QScopedPointer<QNetworkAccessManager> manager;
    QNetworkRequest request;
};

#endif // QMLTEST_API_CLIENT_H
