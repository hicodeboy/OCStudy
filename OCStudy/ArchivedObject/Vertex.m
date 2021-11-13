//
//  Vertex.m
//  OCStudy
//
//  Created by dujia on 2021/4/16.
//

#import "Vertex.h"

@implementation Vertex


- (id)initWithCoder:(NSCoder *)coder
{
  if (self = [super init])
  {
    _location = [(NSValue *)[coder decodeObjectForKey:@"VertexLocation"] CGPointValue];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  [coder encodeObject:[NSValue valueWithCGPoint:_location] forKey:@"VertexLocation"];
}
@end
