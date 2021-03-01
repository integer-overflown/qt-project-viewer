#include <PriorityWidget.hpp>
#include <QPainter>

void PriorityWidget::paint(QPainter* painter)
{
    qreal dw  = (width() - (max_priority - 1) * _padding) / max_priority;
    qreal dh = (height() - _padding) / 2;
    qreal d = std::min(dw, dh);
    const QColor& activeColor = _priority <= low_priority_bound ? _low : _high;

    painter->setPen(Qt::NoPen);
    for (int col = 0; col < 2; ++col) {
        painter->setBrush(QBrush{ activeColor });
        for (int row = 0; row < max_priority; ++row) {
            if (row >= _priority)
                painter->setBrush(QBrush{ _inactive });
            painter->drawEllipse(row * (d + _padding), col * (d + _padding), d, d);
        }
    }
}

void PriorityWidget::setPriority(int priority)
{
    _priority = priority > max_priority ? max_priority
                                        : priority < 0 ? 0 : priority;
    emit priorityChanged();
    update();
}
