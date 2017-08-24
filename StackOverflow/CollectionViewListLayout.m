//
//  CollectionViewListLayout.m
//  StackOverflow
//
//  Created by DVT Hyde Park on 2017/08/22.
//  Copyright © 2017 DVT. All rights reserved.
//

#import "CollectionViewListLayout.h"

@implementation CollectionViewListLayout

-(instancetype)init {
    self = [super init];
    [self initLayoutAttributes];
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

-(void)initLayoutAttributes {
    self.itemHeight = 86;
    self.minimumLineSpacing = 1;
}

-(CGFloat)itemWidth {
    return self.collectionView.frame.size.width;
}

-(CGSize)itemSize {
    return CGSizeMake([self itemWidth], [self itemHeight]);
}

-(void)setItemSize:(CGSize)itemSize {
    self.itemSize = CGSizeMake([self itemWidth], [self itemHeight]);
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
    return self.collectionView.contentOffset;
}

@end
