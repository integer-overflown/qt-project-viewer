#include <TicketModel.hpp>

void TicketModel::setId(int id)
{
    if (_id != id) {
        _id = id;
        emit projectIdChanged();

        if (_token.isEmpty())
            qWarning() << "Attempting to fetch tickets for project[id:" << id << "] with invalid token";

        QPointer provider { new TicketContentProvider(_token, id) };
        QObject::connect(provider, &TicketContentProvider::success, [=](TicketModel::Data data){
            auto last = data.size() - 1;
            beginInsertRows(QModelIndex{}, 0, last);
            modelData = std::move(data);
            endInsertRows();
            emit dataChanged(createIndex(0, 0), createIndex(last, 0));
            provider->deleteLater();
        });
    }
}

int TicketModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return modelData.size();
}

QHash<int, QByteArray> TicketModel::roleNames() const
{
    static const QHash<int, QByteArray> value = {
        { DataRole, "ticket" }
    };
    return value;
}

QVariant TicketModel::data(const QModelIndex& index, int role) const
{
    switch (role) {
    case DataRole:
        return QVariant::fromValue(modelData[index.row()]);
    default:
        return QVariant();
    }
}
