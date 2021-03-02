#include <TicketModel.hpp>
#include <TicketContentProvider.hpp>

TicketModel::TicketModel()
: DataListModelTemplate<Ticket>("ticket") {}

void TicketModel::setId(int id)
{
    if (_id != id) {
        _id = id;
        emit projectIdChanged();

        if (_token.isEmpty())
            qWarning() << "Attempting to fetch tickets for project[id:" << id << "] with invalid token";

        QPointer provider { new TicketContentProvider(_token, id) };
        QObject::connect(provider, &TicketContentProvider::success, this, [=](auto data){
            setData(std::move(data));
            provider->deleteLater();
        });
    }
}

void TicketModel::clear()
{
    DataListModelTemplate<Ticket>::clear();
}
