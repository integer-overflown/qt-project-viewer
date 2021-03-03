#include <IndicesListModel.hpp>

int IndicesListModel::rowCount(const QModelIndex& parent) const
{
    return parent.isValid() ? 0 : _count;
}

void IndicesListModel::push(int count)
{
    auto first = _count, last = first + count - 1;
    beginInsertRows(QModelIndex{}, first, last);
    _count += count;
    endInsertRows();
    emit pushed(count);
}

void IndicesListModel::clear()
{
    auto last = _count - 1;
    beginRemoveRows(QModelIndex{}, 0, last);
    _count = 0;
    endRemoveRows();
}
