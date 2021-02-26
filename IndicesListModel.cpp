#include <IndicesListModel.hpp>

int IndicesListModel::rowCount(const QModelIndex& parent) const
{
    return parent.isValid() ? 0 : _count;
}

void IndicesListModel::push(int count)
{
    beginInsertRows(QModelIndex{}, _count, _count + count - 1);
    _count += count;
    endInsertRows();
}


void IndicesListModel::clear()
{
    beginRemoveRows(QModelIndex{}, 0, _count - 1);
    _count = 0;
    endRemoveRows();
}
