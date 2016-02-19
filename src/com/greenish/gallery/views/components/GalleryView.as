/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.views.components {
import com.greenish.gallery.models.vo.TreeNodeVO;
import flash.display.Sprite;

/**
 * Component for showing all pictures
 */
public class GalleryView extends Sprite {
    private var _renderers:Vector.<ImageRenderer>;

    public function GalleryView() {
        super();
    }

    /**
     * If where was no data before, we should create new renderers. Otherwise we should update old.
     * @param value
     */
    public function set dataProvider(value:Vector.<TreeNodeVO>):void {
        var renderer:ImageRenderer;
        if (_renderers) {
            for (var i:int = 0; i < _renderers.length; i++) {
                renderer = _renderers[i];
                renderer.changeData(value[i]);
            }
        } else {
            _renderers = new Vector.<ImageRenderer>();

            for (i = 0; i < value.length; i++) {
                renderer = new ImageRenderer(value[i]);
                addChild(renderer);
                _renderers.push(renderer);
            }
        }



    }
}
}
