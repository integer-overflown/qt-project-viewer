#ifndef DATA_LIST_MODEL_TEMPLATE_H
#define DATA_LIST_MODEL_TEMPLATE_H
#include <IndicesListModel.hpp>

template<typename DataType>
class DataListModelTemplate : public IndicesListModel
{
public:
    using Container = QVector<DataType>;

    DataListModelTemplate(const char* roleName)
        : _roleName(roleName) {}

    enum Roles {
        DataRole = Qt::UserRole + 1
    };

    QHash<int, QByteArray> roleNames() const override
    {
        static QHash<int, QByteArray> roles {{ DataRole, _roleName }};
        return roles;
    }

    QVariant data(const QModelIndex& index, int role) const override
    {
        switch(role) {
        case DataRole:
            return QVariant::fromValue(modelData[index.row()]);
        default:
            return QVariant();
        }
    }

    void setData(Container data)
    {
        if (modelData.size() > 0)
            IndicesListModel::clear();
        modelData = std::move(data);
        IndicesListModel::push(modelData.size());
    }

    void clear()
    {
        IndicesListModel::clear();
        modelData.clear();
    }

protected:
    Container modelData;
private:
    const char* _roleName;
};

#endif // DATA_LIST_MODEL_TEMPLATE_H
