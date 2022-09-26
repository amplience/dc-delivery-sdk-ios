[![Amplience Dynamic Content](https://github.com/amplience/dc-delivery-sdk-js/raw/master/media/header.png)](https://amplience.com/dynamic-content)

# dc-delivery-sdk-ios

> Official iOS SDK for the Amplience Dynamic Content Delivery API, written in Swift


[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AmplienceDelivery.svg)](https://img.shields.io/cocoapods/v/AmplienceDelivery.svg)

This SDK is designed to help build client side and server side content managed applications.

## Features

- Fetch content and slots using [Content Delivery 1](https://docs.amplience.net/integration/deliveryapi.html#the-content-delivery-api) or [Content Delivery 2](https://docs.amplience.net/development/contentdelivery/readme.html)
- Fetch fresh content and slots for use with SSG build tools using the [Fresh API](https://amplience.com/docs/development/freshapi/fresh-api.html)
- Fetch preview content using Virtual Staging
- Transform content using the [Content Rendering Service](https://docs.amplience.net/integration/contentrenderingservice.html#the-content-rendering-service)
- Transform images on the fly using the [Dynamic Media Service](http://playground.amplience.com/di/app/#/intro)
- Filter Content Items using the [FilterBy](https://amplience.com/docs/development/contentdelivery/filterandsort.html) endpoint


# Requirements

- iOS 13.0+ / tvOS 13.0+ / watchOS 7.0+
- Swift 5.0+

# Installation

## Cocoapods

Add the following to your `Podfile`:
```
pod 'AmplienceDelivery', '~> 1.0.0'
```

Or, quickly try out our examples:
```bash
pod try Amplience
```

## Swift Package Manager

Add the following to your `dependencies` value in `Package.swift`:
```swift
dependencies: [
    .package(url: "https://github.com/amplience/dc-delivery-sdk-ios.git", from: "1.0.0")
]
```


## Usage

Initialise the SDK:

```js
ContentClient.getInstance.configuration = Configuration(hub: "ampproduct-doc", isFresh: false)
```



### Configuration options

| Option             | Description                                                                                                                                                                 |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| hub            | Content Delivery 2 API - Required\* - hubName to retrieve content from - [finding the hub name](https://docs.amplience.net/development/contentdelivery/readme.html#hubname) |
| isFresh             | Fresh API - toggle on/off the Fresh API                                                                                                                                                                |



### Fetch content by delivery ID

The `getContentById(id: )` method accepts a callback which will resolve to the JSON of your slot or content item. If no content is found with the provided ID then the callback will resolve with `error != nil`.

```swift
ContentClient.getInstance.getContentById(id: "bd89c2ed-0ed5-4304-8c89-c0710af500e2") { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                print(error!.localizedDescription)
            } else if let response = response {
                let content = response.content
                // Here, you can instaitate a class from the dictionary within `response.content`
            }
        }
```

The format of the content object will be specific to your content types, which define the JSON structure of content items and slots.


### Fetch content by delivery key

Once you have [set a delivery key for a slot or content item](https://docs.amplience.net/development/delivery-keys/readme.html), the content item must be published with its delivery key before it can be retrieved using this method.

The `getContentByKey(key: )` method accepts a callback which will resolve to the JSON of your slot or content item. If no content is found with the provided key then the callback will resolve with `error != nil`.

```swift
ContentClient.getInstance.getContentByKey(key: "example-key") { [weak self] response, error in
            guard let self = self else { return }
            if error != nil {
                print(error!.localizedDescription)
            } else if let response = response {
                let content = response.content
                // Here, you can instaitate a class from the dictionary within `response.content`
            }
        }
```

The format of the content object will be specific to your content types, which define the JSON structure of content items and slots.

### Filtering Content Items

Content can be filtered and sorted using the `filterContent()` method.

This method accepts a `FilterContentRequest` instance which allows for an array of `filterBy` which are `FilterBy`-type filters in a logical AND chaining. The model also allows for an optional `sortBy` which allows for sorting by `ASC` or `DSC` and an optional `page` key of `Page` class instance. The `Page` class allows for `size` and `cursor` to be specified to enable pagination.


### Fetching multiple Content Items in a single request

Fetch multiple by delivery id e.g.,

```swift
ContentClient.getInstance.listContentById(ids: [
  "d6ccc158-6ab7-48d0-aa85-d9fbf2aef000",
  "b322f84a-9719-42ff-a6a0-6e2924608d19",
]);
```

or by delivery key e.g.,

```swift
ContentClient.getInstance.listContentByKey(keys: ["blog/article-1", "blog/article-2"]);
```

### Preview staging content

By default, the content client will request content from the production content delivery services. When a user wants to preview content before it is published you can re-point the client to a virtual staging environment (VSE) and set the VSE's endpoint in `UserDefaults` in the `stagingEnvironment` key.

Dynamic Content generates a VSE for each user and typically passes the "stagingEnvironment" value into your application using an UserDefaults value on SDK Initialisation. This allows each user to effectively have their own staging environment which allows content producers to work in parallel.


## Documentation

Please use the following documentation resources to assist building your application:

- Dynamic Content Delivery API 2 [Reference documentation](https://amplience.com/docs/development/contentdelivery/readme.html)
- Dynamic Content Fresh API [Reference documentation](https://amplience.com/docs/development/contentdelivery/filterapiintro.html)
- Dynamic Content [User guide](https://docs.amplience.net/)

## Getting Help

If you need help using the SDK please reach out using one of the following channels:

- Ask a question on [StackOverflow](https://stackoverflow.com/) using the tag `amplience-dynamic-content`
- Open a support ticket with [Amplience Support](https://support.amplience.com/)
- Contact your [Amplience Customer Success](https://amplience.com/customer-success) representative
- If you have found a bug please report it by [opening an issue](https://github.com/amplience/dc-delivery-sdk-js/issues/new)

## License

This software is licensed under the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0),

Copyright 2022 Amplience

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
