#ifndef QMLTEST_TICKET_CONTENT_PROVIDER_H
#define QMLTEST_TICKET_CONTENT_PROVIDER_H
#include <ContentProvider.hpp>
#include <Ticket.hpp>

class TicketContentProvider : public QObject, private ContentProvider<Ticket>
{
    Q_OBJECT
public:
    using Data = ContentProvider<Ticket>::Data;
    TicketContentProvider(const QString& token, const int id, QObject* parent = nullptr);
signals:
    void success(Data);
private:
    Ticket handleNextObject(const QJsonObject&) const override;
    void ready(Data) override;
};

#endif // QMLTEST_TICKET_CONTENT_PROVIDER_H
