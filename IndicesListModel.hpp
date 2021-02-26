#ifndef QMLTEST_MODEL_BASE_H
#define QMLTEST_MODEL_BASE_H
#include <QAbstractListModel>

class IndicesListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString token MEMBER _token NOTIFY tokenChanged REQUIRED)
public:
    int rowCount(const QModelIndex&) const override;
    // QAbstractListModel::roleNames()
    // QAbstractListModel::data(const QModelIndex&, int)
    // are going to be overriden by children
signals:
    void tokenChanged();
protected:
    // mimic list data structure just to record length changes
    void push(int count = 1);
    void clear();
    // those above are sufficient
protected:
    QString _token;
private:
    int _count {0};
};

#endif // QMLTEST_MODEL_BASE_H
