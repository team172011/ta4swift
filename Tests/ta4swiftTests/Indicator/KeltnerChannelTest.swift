//
//  KeltnerChannelTest.swift
//  
//
//  Created by Simon-Justus Wimmer on 12.03.22.
//

import Foundation
import Logging
@testable import ta4swift

public final class KeltnerChannelTest: Ta4swiftTest {
    
    func testKeltnerChannel() {
        let barSeries = BarSeries(name: "Test")
        
        barSeries.bars.append(Bar(openPrice: 11577.43, highPrice: 11711.47, lowPrice: 11577.35, closePrice: 11670.75, volume: 0, beginTime: Date()-2))
        barSeries.bars.append(Bar(openPrice: 11670.9, highPrice: 11698.22, lowPrice: 11635.74, closePrice: 11691.18, volume: 0, beginTime: Date()-3))
        barSeries.bars.append(Bar(openPrice: 11688.61, highPrice: 11742.68, lowPrice: 11652.89, closePrice: 11722.89, volume: 0, beginTime: Date()-4))
        barSeries.bars.append(Bar(openPrice: 11716.93, highPrice: 11736.74, lowPrice: 11667.46, closePrice: 11697.31, volume: 0, beginTime: Date()-5))
        barSeries.bars.append(Bar(openPrice: 11696.86, highPrice: 11726.94, lowPrice: 11599.68, closePrice: 11674.76, volume: 0, beginTime: Date()-6))
        barSeries.bars.append(Bar(openPrice: 11672.34, highPrice: 11677.33, lowPrice: 11573.87, closePrice: 11637.45, volume: 0, beginTime: Date()-7))
        barSeries.bars.append(Bar(openPrice: 11638.51, highPrice: 11704.12, lowPrice: 11635.48, closePrice: 11671.88, volume: 0, beginTime: Date()-8))
        barSeries.bars.append(Bar(openPrice: 11673.62, highPrice: 11782.23, lowPrice: 11673.62, closePrice: 11755.44, volume: 0, beginTime: Date()-9))
        barSeries.bars.append(Bar(openPrice: 11753.7, highPrice: 11757.25, lowPrice: 11700.53, closePrice: 11731.9, volume: 0, beginTime: Date()-10))
        barSeries.bars.append(Bar(openPrice: 11732.13, highPrice: 11794.15, lowPrice: 11698.83, closePrice: 11787.38, volume: 0, beginTime: Date()-11))
        barSeries.bars.append(Bar(openPrice: 11783.82, highPrice: 11858.78, lowPrice: 11777.99, closePrice: 11837.93, volume: 0, beginTime: Date()-12))
        barSeries.bars.append(Bar(openPrice: 11834.21, highPrice: 11861.24, lowPrice: 11798.46, closePrice: 11825.29, volume: 0, beginTime: Date()-13))
        barSeries.bars.append(Bar(openPrice: 11823.7, highPrice: 11845.16, lowPrice: 11744.77, closePrice: 11822.8, volume: 0, beginTime: Date()-14))
        barSeries.bars.append(Bar(openPrice: 11822.95, highPrice: 11905.48, lowPrice: 11822.8, closePrice: 11871.84, volume: 0, beginTime: Date()-15))
        barSeries.bars.append(Bar(openPrice: 11873.43, highPrice: 11982.94, lowPrice: 11867.98, closePrice: 11980.52, volume: 0, beginTime: Date()-16))
        barSeries.bars.append(Bar(openPrice: 11980.52, highPrice: 11985.97, lowPrice: 11898.74, closePrice: 11977.19, volume: 0, beginTime: Date()-17))
        barSeries.bars.append(Bar(openPrice: 11978.85, highPrice: 12020.52, lowPrice: 11961.83, closePrice: 11985.44, volume: 0, beginTime: Date()-18))
        barSeries.bars.append(Bar(openPrice: 11985.36, highPrice: 12019.53, lowPrice: 11971.93, closePrice: 11989.83, volume: 0, beginTime: Date()-19))
        barSeries.bars.append(Bar(openPrice: 11824.39, highPrice: 11891.93, lowPrice: 11817.88, closePrice: 11891.93, volume: 0, beginTime: Date()-20))
        barSeries.bars.append(Bar(openPrice: 11892.5, highPrice: 12050.75, lowPrice: 11892.5, closePrice: 12040.16, volume: 0, beginTime: Date()-21))
        barSeries.bars.append(Bar(openPrice: 12038.27, highPrice: 12057.91, lowPrice: 12018.51, closePrice: 12041.97, volume: 0, beginTime: Date()-22))
        barSeries.bars.append(Bar(openPrice: 12040.68, highPrice: 12080.54, lowPrice: 11981.05, closePrice: 12062.26, volume: 0, beginTime: Date()-23))
        barSeries.bars.append(Bar(openPrice: 12061.73, highPrice: 12092.42, lowPrice: 12025.78, closePrice: 12092.15, volume: 0, beginTime: Date()-24))
        barSeries.bars.append(Bar(openPrice: 12092.38, highPrice: 12188.76, lowPrice: 12092.3, closePrice: 12161.63, volume: 0, beginTime: Date()-25))
        barSeries.bars.append(Bar(openPrice: 12152.7, highPrice: 12238.79, lowPrice: 12150.05, closePrice: 12233.15, volume: 0, beginTime: Date()-26))
        barSeries.bars.append(Bar(openPrice: 12229.29, highPrice: 12254.23, lowPrice: 12188.19, closePrice: 12239.89, volume: 0, beginTime: Date()-27))
        barSeries.bars.append(Bar(openPrice: 12239.66, highPrice: 12239.66, lowPrice: 12156.94, closePrice: 12229.29, volume: 0, beginTime: Date()-28))
        barSeries.bars.append(Bar(openPrice: 12227.78, highPrice: 12285.94, lowPrice: 12180.48, closePrice: 12273.26, volume: 0, beginTime: Date()-29))
        barSeries.bars.append(Bar(openPrice: 12266.83, highPrice: 12276.21, lowPrice: 12235.91, closePrice: 12268.19, volume: 0, beginTime: Date()-30))
        barSeries.bars.append(Bar(openPrice: 12266.75, highPrice: 12267.66, lowPrice: 12193.27, closePrice: 12226.64, volume: 0, beginTime: Date()-31))
        barSeries.bars.append(Bar(openPrice: 12219.79, highPrice: 12303.16, lowPrice: 12219.79, closePrice: 12288.17, volume: 0, beginTime: Date()-32))
        barSeries.bars.append(Bar(openPrice: 12287.72, highPrice: 12331.31, lowPrice: 12253.24, closePrice: 12318.14, volume: 0, beginTime: Date()-33))
        barSeries.bars.append(Bar(openPrice: 12389.74, highPrice: 12389.82, lowPrice: 12176.31, closePrice: 12212.79, volume: 0, beginTime: Date()-34))
        
        
        let keltnerChannel = KeltnerChannel(emaBarCount: 14, atrBarCount: 14, k: 2)
        accuracy = 0.0001
        
        // middle keltner channel line
        assertEqualsT(11764.2300, keltnerChannel.middle.calc(barSeries, 13))
        assertEqualsT(11793.0687, keltnerChannel.middle.calc(barSeries, 14))
        assertEqualsT(11817.6182, keltnerChannel.middle.calc(barSeries, 15))
        assertEqualsT(11839.9944, keltnerChannel.middle.calc(barSeries, 16))
        assertEqualsT(11859.9725, keltnerChannel.middle.calc(barSeries, 17))
        assertEqualsT(11864.2335, keltnerChannel.middle.calc(barSeries, 18))
        assertEqualsT(11887.6903, keltnerChannel.middle.calc(barSeries, 19))
        assertEqualsT(11908.2609, keltnerChannel.middle.calc(barSeries, 20))
        assertEqualsT(11928.7941, keltnerChannel.middle.calc(barSeries, 21))
        assertEqualsT(11950.5749, keltnerChannel.middle.calc(barSeries, 22))
        assertEqualsT(11978.7156, keltnerChannel.middle.calc(barSeries, 23))
        assertEqualsT(12012.6402, keltnerChannel.middle.calc(barSeries, 24))
        assertEqualsT(12042.9401, keltnerChannel.middle.calc(barSeries, 25))
        assertEqualsT(12067.7868, keltnerChannel.middle.calc(barSeries, 26))
        assertEqualsT(12095.1832, keltnerChannel.middle.calc(barSeries, 27))
        assertEqualsT(12118.2508, keltnerChannel.middle.calc(barSeries, 28))
        assertEqualsT(12132.7027, keltnerChannel.middle.calc(barSeries, 29))
        
        // lower keltner channel line
        assertEqualsT(11556.5468, keltnerChannel.lower.calc(barSeries, 13))
        assertEqualsT(11583.7971, keltnerChannel.lower.calc(barSeries, 14))
        assertEqualsT(11610.8331, keltnerChannel.lower.calc(barSeries, 15))
        assertEqualsT(11639.5955, keltnerChannel.lower.calc(barSeries, 16))
        assertEqualsT(11667.0877, keltnerChannel.lower.calc(barSeries, 17))
        assertEqualsT(11660.5619, keltnerChannel.lower.calc(barSeries, 18))
        assertEqualsT(11675.8782, keltnerChannel.lower.calc(barSeries, 19))
        assertEqualsT(11705.9497, keltnerChannel.lower.calc(barSeries, 20))
        assertEqualsT(11726.7208, keltnerChannel.lower.calc(barSeries, 21))
        assertEqualsT(11753.4154, keltnerChannel.lower.calc(barSeries, 22))
        assertEqualsT(11781.8375, keltnerChannel.lower.calc(barSeries, 23))
        assertEqualsT(11817.1476, keltnerChannel.lower.calc(barSeries, 24))
        assertEqualsT(11851.9771, keltnerChannel.lower.calc(barSeries, 25))
        assertEqualsT(11878.6139, keltnerChannel.lower.calc(barSeries, 26))
        assertEqualsT(11904.4570, keltnerChannel.lower.calc(barSeries, 27))
        assertEqualsT(11935.3907, keltnerChannel.lower.calc(barSeries, 28))
        assertEqualsT(11952.2012, keltnerChannel.lower.calc(barSeries, 29))
        
        // upper keltner channel line
        assertEqualsT(11971.9132, keltnerChannel.upper.calc(barSeries, 13))
        assertEqualsT(12002.3402, keltnerChannel.upper.calc(barSeries, 14))
        assertEqualsT(12024.4032, keltnerChannel.upper.calc(barSeries, 15))
        assertEqualsT(12040.3933, keltnerChannel.upper.calc(barSeries, 16))
        assertEqualsT(12052.8572, keltnerChannel.upper.calc(barSeries, 17))
        assertEqualsT(12067.9050, keltnerChannel.upper.calc(barSeries, 18))
        assertEqualsT(12099.5025, keltnerChannel.upper.calc(barSeries, 19))
        assertEqualsT(12110.5722, keltnerChannel.upper.calc(barSeries, 20))
        assertEqualsT(12130.8675, keltnerChannel.upper.calc(barSeries, 21))
        assertEqualsT(12147.7344, keltnerChannel.upper.calc(barSeries, 22))
        assertEqualsT(12175.5937, keltnerChannel.upper.calc(barSeries, 23))
        assertEqualsT(12208.1327, keltnerChannel.upper.calc(barSeries, 24))
        assertEqualsT(12233.9032, keltnerChannel.upper.calc(barSeries, 25))
        assertEqualsT(12256.9596, keltnerChannel.upper.calc(barSeries, 26))
        assertEqualsT(12285.9094, keltnerChannel.upper.calc(barSeries, 27))
        assertEqualsT(12301.1108, keltnerChannel.upper.calc(barSeries, 28))
        assertEqualsT(12313.2042, keltnerChannel.upper.calc(barSeries, 29))
    }
}
