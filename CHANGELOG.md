## 0.2.0

* **BREAKING CHANGE**: The layout logic has been completely reworked using a custom `RenderObject`.
* The widget now correctly shrinks to fit its content, allowing it to be used in `Stack`, `Column`, etc.
* The widget now automatically scales down to fit within its parent's constraints, preventing overflow errors.
* Removed the `@visibleForTesting` `MosaicLayoutDelegate` as it is no longer used.

## 0.1.0

* Initial release of the `mosaic_cloud` package.
* Provides a `MosaicCloud` widget for creating dense, non-overlapping layouts.
* Includes a spiral-based algorithm for widget placement.

## 0.0.1

* Initial version.