# multiple_status_widget

## 多状态加载布局 package.

StatusController controller;

@override
    void initState() {
    controller = StatusController();
    super.initState();
}

Container(
    child: MultipleStatusWidget(
      controller: controller,
        retryingCallback: () {
          controller.setLoading();
        },
        child: Inner(),
    ),
)

