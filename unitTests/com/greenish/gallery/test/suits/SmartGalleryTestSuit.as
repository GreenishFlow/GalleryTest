/**
 * Created by evgeny on 18.02.16.
 */
package com.greenish.gallery.test.suits {
import com.greenish.gallery.test.cases.TestImageLoaderService;
import com.greenish.gallery.test.cases.TestSmartGalleryModel;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class SmartGalleryTestSuit {
    public var testImageLoaderService:TestImageLoaderService;
    public var testSmartGalleryModel:TestSmartGalleryModel;
}
}
