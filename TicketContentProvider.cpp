#include <TicketContentProvider.hpp>
#include <private/Credentials.hpp>

TicketContentProvider::TicketContentProvider(const QString& token, const int id, QObject* parent)
: QObject(parent), ContentProvider<Ticket>(api::path(api::tickets, QString::number(id)), token, "tickets")
{}

Ticket TicketContentProvider::handleNextObject(const QJsonObject& o) const
{
    return Ticket {
        o["id"].toInt(),
        o["priority"].toInt(),
        o["name"].toString(),
        o["description"].toString()
    };
}

void TicketContentProvider::ready(TicketContentProvider::Data data)
{
    emit success(std::move(data));
}
