//
//  CollectionViewCustonLayout.swift
//  VK_Nikita
//
//  Created by Никита Троян on 05.10.2021.
//

import UIKit

class CollectionViewCustomLayout:UICollectionViewLayout {
    // словарь всех аттрибутов, ключ это номер ячейки
    var casheAttributes = [IndexPath:UICollectionViewLayoutAttributes]()
    // кол-во колонн
    var columnsCount = 2
    // высота ячейки
    var cellHeight: CGFloat = 300
    // сюда мы будем записывать общую высоту всех ячеек
    var insets: CGFloat = 0
    private var totalCellsHeight: CGFloat = 0
    
    //переопределяем метод, который подготавливает все размеры ячеек
    override func prepare() {
        //инициализируем словарь
        self.casheAttributes = [:]
        //проверяем есть ли у нас таблица
        guard let collectionView = self.collectionView else { return }
        // проверям есть ли у нулевой секции элементы для показа
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else {
            return
        }
        
        //вычисляем ширину для большой и маленькой ячейки
        let bigCellWidth = (collectionView.frame.width - self.insets)
        let littleCellWidth = (collectionView.frame.width - self.insets) / CGFloat(self.columnsCount) - self.insets
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        
        //здесь мы создаём цикл, который пройдётся по всем элементам коллекции(по нам квадратам)
        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let isBigCell = (index + 1) % (self.columnsCount + 1) == 0
            
            if isBigCell {
                attributes.frame = CGRect(x: 0 + self.insets,y: lastY,
                                          width: bigCellWidth,height: self.cellHeight)
                
                lastY += (self.cellHeight + self.insets)
                casheAttributes[indexPath] = attributes
            } else {
                attributes.frame = CGRect(x: lastX + self.insets,y: lastY,
                                          width: littleCellWidth,height: self.cellHeight)
                
                let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
                
                if isLastColumn {
                    lastX = 0
                    lastY += (self.cellHeight + self.insets)
                } else {
                    lastX += (littleCellWidth + self.insets)
                }
                casheAttributes[indexPath] = attributes
            }
            casheAttributes[indexPath] = attributes
            totalCellsHeight = lastY
        }
        
    }
    // метод, который передаёт кусочек экрана, который требуется отрисовать
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return casheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }
    // метод, который отрисовывает каждый элемент из метода сверху
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return casheAttributes[indexPath]
    }
    // общий размер того, что будет помещено в таблицу
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView!.frame.width ,
                      height: self.totalCellsHeight)
    }
    
    
}
