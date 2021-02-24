#include <ProjectModel.hpp>

void ProjectModel::setToken(const QString& token)
{
    if (token == _token)
        return;
    emit tokenChanged(token);

    QPointer provider { new ProjectContentProvider(token) };
    QObject::connect(provider, &ProjectContentProvider::success, [=](ProjectModel::Data projectList){
        beginInsertRows(QModelIndex{}, 0, projectList.size() - 1);
        modelData = std::move(projectList);
        endInsertRows();
        emit dataChanged(createIndex(0, 0), createIndex(modelData.size(), 0), { DataRole });
        provider->deleteLater();
    });
}

int ProjectModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return modelData.size();
}

QHash<int, QByteArray> ProjectModel::roleNames() const
{
    static const QHash<int, QByteArray> value = {
        { DataRole, "project" }
    };
    return value;
}

QVariant ProjectModel::data(const QModelIndex& index, int role) const
{
    switch (role) {
    case DataRole:
        return QVariant::fromValue(modelData[index.row()]);
    default:
        return QVariant();
    }
}
