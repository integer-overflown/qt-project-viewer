function instantiateObject(url, parent, properties) {
    const componentFactory = Qt.createComponent(url);
    switch(componentFactory.status) {
    case Component.Ready:
        return componentFactory.createObject(parent, properties);
    case Component.Error:
        console.log(componentFactory.errorString());
    }
}
