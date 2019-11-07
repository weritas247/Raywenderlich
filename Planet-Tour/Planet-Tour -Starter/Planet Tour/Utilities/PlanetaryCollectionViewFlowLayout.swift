
///
/// Thanks to StackOverflow user "Haurus" for the top-aligned CollectionViewFlowLayout
/// code. (See here: http://goo.gl/ISUiD2)

import UIKit

class PlanetaryCollectionViewFlowLayout: UICollectionViewFlowLayout {

  // MARK: - Properties
  let topSpacing: CGFloat = 80
  let betweenSpacing: CGFloat = 10

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superAttributes = super.layoutAttributesForElements(in: rect),
      let attributesToReturn = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
        return nil
    }

    for attribute in attributesToReturn where attribute.representedElementKind == nil {
      guard let itemLayoutAttributes = layoutAttributesForItem(at: attribute.indexPath) else { continue }

      attribute.frame = itemLayoutAttributes.frame
    }

    return attributesToReturn
  }

  // This gives us a top-aligned horizontal layout
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let superItemAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }

    guard let currentItemAttributes = superItemAttributes.copy() as? UICollectionViewLayoutAttributes else { return nil }
    guard let collectionView = collectionView else { return nil }
    guard let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset else { return nil }
    
    if indexPath.item == 0 {
      var frame = currentItemAttributes.frame
      frame.origin.y = sectionInset.top + topSpacing
      currentItemAttributes.frame = frame
      return currentItemAttributes
    }
    
    let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
    guard let previousFrame = layoutAttributesForItem(at: previousIndexPath)?.frame else { return nil }

    let previousFrameRightPoint = previousFrame.origin.y + previousFrame.size.height + betweenSpacing
    let previousFrameTop = previousFrame.origin.y
    let currentFrame = currentItemAttributes.frame
    let stretchedCurrentFrame =  CGRect(x: currentFrame.origin.x, y: previousFrameTop, width: currentFrame.size.width, height: collectionView.frame.size.height)
    if !previousFrame.intersects(stretchedCurrentFrame) {
      var frame = currentItemAttributes.frame
      frame.origin.y = sectionInset.top + topSpacing
      currentItemAttributes.frame = frame
      return currentItemAttributes
    }

    var frame = currentItemAttributes.frame
    frame.origin.y = previousFrameRightPoint
    currentItemAttributes.frame = frame
    return currentItemAttributes
  }

  // This controlls the scrolling of the collection view so that it comes to rest with the closest
  // planet on the center of the screen
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let cv = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }

    let cvBounds = cv.bounds
    let halfWidth = cvBounds.size.width * 0.5;
    let proposedContentOffsetCenterX = proposedContentOffset.x + halfWidth;
    if let attributesForVisibleCells = layoutAttributesForElements(in: cvBounds) as [UICollectionViewLayoutAttributes]? {
      let closestAttribute = attributesForVisibleCells.reduce(nil) { (closest : UICollectionViewLayoutAttributes?, nextAttribute) in
        getClosestAttribute(closest, nextAttribute: nextAttribute, targetCenterX: proposedContentOffsetCenterX)
      }
      return CGPoint(x: closestAttribute!.center.x - halfWidth, y: proposedContentOffset.y)
    }

    return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
  }

  func getClosestAttribute(_ closestSoFar: UICollectionViewLayoutAttributes?, nextAttribute: UICollectionViewLayoutAttributes, targetCenterX: CGFloat) -> UICollectionViewLayoutAttributes? {
    if closestSoFar == nil {
      return nextAttribute
    } else if fabs(nextAttribute.center.x - targetCenterX) < fabs(closestSoFar!.center.x - targetCenterX) {
      return nextAttribute
    }
    return closestSoFar
  }
}
