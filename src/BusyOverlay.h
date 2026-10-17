#ifndef MUON_BUSYOVERLAY_H
#define MUON_BUSYOVERLAY_H

#include <KBusyIndicatorWidget>
#include <QEvent>
#include <QGridLayout>

// Center the current theme's busy indicator over a scroll area's viewport.
class BusyOverlay : public QWidget
{
public:
    explicit BusyOverlay(QWidget *viewport)
        : QWidget(viewport), m_indicator(new KBusyIndicatorWidget(this))
    {
        setAttribute(Qt::WA_TransparentForMouseEvents);
        auto *layout = new QGridLayout(this);
        layout->addWidget(m_indicator, 0, 0, Qt::AlignCenter);
        m_indicator->setFixedSize(32, 32);
        viewport->installEventFilter(this);
        setGeometry(viewport->rect());
        hide();
    }

    void start()
    {
        setGeometry(parentWidget()->rect());
        m_indicator->setRunning(true);
        show();
        raise();
    }

    void stop()
    {
        m_indicator->setRunning(false);
        hide();
    }

protected:
    bool eventFilter(QObject *watched, QEvent *event) override
    {
        if (watched == parentWidget() && event->type() == QEvent::Resize) {
            setGeometry(parentWidget()->rect());
        }
        return QWidget::eventFilter(watched, event);
    }

private:
    KBusyIndicatorWidget *m_indicator;
};

#endif
