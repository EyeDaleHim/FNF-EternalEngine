package funkin.objects.sprites;

import flixel.graphics.frames.FlxFrame;
import flixel.addons.display.FlxTiledSprite;

// FlxTiledSprite extension with scaling support and a fix to make tiles smoother, original by RapperGF
class TiledSprite extends FlxTiledSprite {
    override function updateVerticesData():Void {
        if (graphic == null)
            return;

        var frame:FlxFrame = graphic.imageFrame.frame;
        graphicVisible = true;

        if (repeatX) {
            vertices[0] = vertices[6] = 0.0;
            vertices[2] = vertices[4] = width;

            uvtData[0] = uvtData[6] = -scrollX / frame.sourceSize.x;
            uvtData[2] = uvtData[4] = (uvtData[0] + width / frame.sourceSize.x) / scale.x;
        } else {
            vertices[0] = vertices[6] = FlxMath.bound(scrollX, 0, width);
            vertices[2] = vertices[4] = FlxMath.bound(scrollX + frame.sourceSize.x, 0, width);

            if (vertices[2] - vertices[0] <= 0) {
                graphicVisible = false;
                return;
            }

            uvtData[0] = uvtData[6] = (vertices[0] - scrollX) / frame.sourceSize.x;
            uvtData[2] = uvtData[4] = (uvtData[0] + (vertices[2] - vertices[0]) / frame.sourceSize.x) / scale.x;
        }

        if (repeatY) {
            var uvMargin:Float = 1.0 / frame.sourceSize.y;

            vertices[1] = vertices[3] = 0.0;
            vertices[5] = vertices[7] = height;

            uvtData[1] = uvtData[3] = (-scrollY / frame.sourceSize.y) + uvMargin;
            uvtData[5] = uvtData[7] = (uvtData[1] * frame.sourceSize.y + (height / scale.y)) / frame.sourceSize.y + uvMargin;
        } else {
            vertices[1] = vertices[3] = FlxMath.bound(scrollY, 0, height);
            vertices[5] = vertices[7] = FlxMath.bound(scrollY + frame.sourceSize.y, 0, height);

            if (vertices[5] - vertices[1] <= 0) {
                graphicVisible = false;
                return;
            }

            uvtData[1] = uvtData[3] = (vertices[1] - scrollY) / frame.sourceSize.y;
            uvtData[5] = uvtData[7] = uvtData[1] + ((vertices[5] - vertices[1]) / scale.y) / frame.sourceSize.y;
        }
    }
}
