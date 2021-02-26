#ifndef QMLTEST_TICKET_MODEL_H
#define QMLTEST_TICKET_MODEL_H
#include <QAbstractListModel>
#include <QtQml>
#include <TicketContentProvider.hpp>

class TicketModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString token MEMBER _token REQUIRED)
    Q_PROPERTY(int projectId WRITE setId MEMBER _id NOTIFY projectIdChanged)
    QML_ELEMENT
public:
    using Data = TicketContentProvider::Data;
    enum Roles {
        DataRole = Qt::UserRole + 1
    };
    int rowCount(const QModelIndex&) const override;
    QVariant data(const QModelIndex&, int) const override;
    QHash<int, QByteArray> roleNames() const override;
public slots:
    void setId(int);
signals:
    void projectIdChanged();
private:
    QList<Ticket> modelData;
    QString _token;
    int _id;
};

#endif // QMLTEST_TICKET_MODEL_H
