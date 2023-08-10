import "../../router"
import QtQuick 2.11
import QtQuick.Controls 2.4
import org.deepin.dtk 1.0

SearchEdit {
    placeholder: "搜索"
    Keys.onReturnPressed: {
        if (text.length <= 0)
            return ;

        console.log("SearchEdit: 回车触发");
        if (Router.routeCurrent.path == "search")
            Router.showSearch(text, true);
        else
            Router.showSearch(text);
    }
}
