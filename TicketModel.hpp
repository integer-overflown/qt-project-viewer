#ifndef QMLTEST_TICKET_MODEL_H
#define QMLTEST_TICKET_MODEL_H
#include <QtQml>
#include <DataListModelTemplate.hpp>
#include <TicketContentProvider.hpp>
#include <Ticket.hpp>

class TicketModel : public DataListModelTemplate<Ticket>
{
    Q_OBJECT
    Q_PROPERTY(int projectId WRITE setId MEMBER _id NOTIFY projectIdChanged)
    QML_ELEMENT
public:
    TicketModel();
public slots:
    void setId(int);
    Q_INVOKABLE void clear();
signals:
    void projectIdChanged();
private:
    int _id;
};
#endif // QMLTEST_TICKET_MODEL_H
