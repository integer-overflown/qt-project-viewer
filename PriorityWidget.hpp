#ifndef QMLTEST_PRIORITY_WIDGET
#define QMLTEST_PRIORITY_WIDGET
#include <QQuickPaintedItem>
#include <QtQml>

class PriorityWidget : public QQuickPaintedItem
{
    Q_OBJECT
    Q_PROPERTY(QColor colorInactive MEMBER _inactive)
    Q_PROPERTY(QColor colorLow MEMBER _low)
    Q_PROPERTY(QColor colorHigh MEMBER _high)
    Q_PROPERTY(qreal padding MEMBER _padding)
    Q_PROPERTY(int priority WRITE setPriority MEMBER _priority)
    QML_ELEMENT
public:
    void paint(QPainter*) override;
    void setPriority(int);
signals:
    void priorityChanged();
private:
    static constexpr int max_priority = 5;
    static constexpr int low_priority_bound = 3;
    QColor _inactive { "lightgray" }, _low { "gray" }, _high { "orange" };
    qreal _padding { 2 };
    int _priority { 0 };
};

#endif // QMLTEST_PRIORITY_WIDGET
