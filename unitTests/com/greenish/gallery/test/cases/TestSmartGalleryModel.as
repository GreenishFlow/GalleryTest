/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.test.cases {
import com.greenish.gallery.models.SmartGalleryModel;
import com.greenish.gallery.models.vo.SmartGalleryVO;
import com.greenish.gallery.models.vo.TreeNodeVO;

import org.flexunit.Assert;

public class TestSmartGalleryModel {
    private var _galleryModel:SmartGalleryModel;

    [Before]
    public function setUp():void
    {
        this._galleryModel = new SmartGalleryModel()
    }

    [After]
    public function tearDown():void
    {
        this._galleryModel = null;
    }

    [Test]
    public function testSetGallery():void
    {
        var nodes:Vector.<TreeNodeVO> = new Vector.<TreeNodeVO>();
        this._galleryModel.nodes = nodes;
        Assert.assertEquals("galleryModel should have a gallery",
                this._galleryModel.nodes != null, true );
    }
}
}
