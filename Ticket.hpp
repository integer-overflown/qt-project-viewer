#ifndef QMLTEST_TICKET_H
#define QMLTEST_TICKET_H
#include <QObject>

struct Ticket
{
    Q_GADGET
    Q_PROPERTY(int id MEMBER id)
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString description MEMBER description)
public:
    Ticket(int id, int priority, QString name, QString description)
    : id(id), priority(priority), name(std::move(name)), description(std::move(description))
    {}
private:
    int id;
    int priority;
    QString name;
    QString description;
};

#endif // QMLTEST_TICKET_H
