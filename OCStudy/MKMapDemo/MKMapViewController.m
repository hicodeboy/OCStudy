//
//  MKMapViewController.m
//  OCStudy
//
//  Created by dujia on 2021/6/24.
//

#import "MKMapViewController.h"
#import <MapKit/MapKit.h>

@interface MKMapViewController () <MKMapViewDelegate>
@property (retain, nonatomic) MKPolyline* routeLine;
@property (retain, nonatomic) MKMapView* mapView;
@property (retain, nonatomic) MKPolylineView* routeLineView;
@end

@implementation MKMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MKMapView* mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.delegate = self;
    [self.view addSubview:mapView];

    self.mapView = mapView;
    
    [self drawLine];
}

- (void)drawLineWithLocationArray:(NSArray *)locationArray
{
    NSInteger pointCount = [locationArray count];
    CLLocationCoordinate2D *coordinateArray = (CLLocationCoordinate2D *)malloc(pointCount * sizeof(CLLocationCoordinate2D));

    for (int i = 0; i < pointCount; ++i) {
        CLLocation *location = [locationArray objectAtIndex:i];
        coordinateArray[i] = [location coordinate];
        // 添加大头针
        MKPointAnnotation *ann = [[MKPointAnnotation alloc] init];
        ann.coordinate = [location coordinate];
        [ann setTitle:[NSString stringWithFormat:@"%i",i]];
        [ann setSubtitle:@""];
        [_mapView addAnnotation:ann];

    }

    self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:pointCount];
    [self.mapView setVisibleMapRect:[self.routeLine boundingMapRect]];
    [self.mapView addOverlay:self.routeLine];

    free(coordinateArray);
    coordinateArray = NULL;
}

// 画线的委托实现方法
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay
{
    if(overlay == self.routeLine) {
        if(nil == self.routeLineView) {
            self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
            self.routeLineView.fillColor = [UIColor blueColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 5;
        }
        return self.routeLineView;
    }
    return nil;
}
// 添加大头针的委托实现方法
//- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    MKPinAnnotationView *pinView = nil;
//
//    static NSString *defaultPinID = @"pinId";
//    pinView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//    if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
//                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
//    pinView.pinTintColor = [UIColor redColor];
//    pinView.canShowCallout = YES;
//    pinView.animatesDrop = YES;
//    return pinView;
//}


- (void)drawLine
{

// 如果存在线，移除
    if (self.mapView.annotations.count > 0) {
        [self.mapView removeAnnotations:_mapView.annotations];
        [self.mapView removeOverlays:_mapView.overlays];
        return;
    }

    // 模拟经纬度坐标点
    CLLocation *location0 = [[CLLocation alloc] initWithLatitude:39.954245 longitude:116.312455];
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:38.954245 longitude:116.512455];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:37.954245 longitude:116.612455];
    CLLocation *location3 = [[CLLocation alloc] initWithLatitude:36.954245 longitude:116.712455];
    CLLocation *location4 = [[CLLocation alloc] initWithLatitude:35.954245 longitude:116.812455];
    CLLocation *location5 = [[CLLocation alloc] initWithLatitude:34.954245 longitude:117.312455];
    CLLocation *location6 = [[CLLocation alloc] initWithLatitude:33.954245 longitude:118.312455];
    CLLocation *location7 = [[CLLocation alloc] initWithLatitude:32.954245 longitude:119.312455];
    CLLocation *location8 = [[CLLocation alloc] initWithLatitude:31.954245 longitude:119.612455];
    CLLocation *location9 = [[CLLocation alloc] initWithLatitude:30.247871 longitude:120.127683];

    NSArray *array = [NSArray arrayWithObjects:location0, location1,location2,location3,location4,location5,location6,location7,location8,location9, nil];
    [self drawLineWithLocationArray:array];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
