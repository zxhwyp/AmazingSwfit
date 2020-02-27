//
//  ViewController.swift
//  AmazingSwfit
//
//  Created by 周小华 on 2020/2/4.
//  Copyright © 2020 周小华. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxDataSources

class ViewController: UIViewController {
    
    var tbView: UITableView!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }

    
    func layoutUI() {
        self.title = "演示demo"
        tbView = UITableView.init()
        view.addSubview(tbView)
        tbView.snp_makeConstraints { make in
            make.edges.equalTo(view).inset(UIEdgeInsets.zero)
        }
        
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tbView.register(CellTest.self, forCellReuseIdentifier: "ImportantCell")
/* 加载单个section时使用的方法
        let texts = ["Objective-C", "Swift", "RXSwift"]
        let ob = Observable.from(optional: texts)
        ob.bind(to: tbView.rx
                    .items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, text, cell) in
                        cell.textLabel?.text = text
                    }
                    .disposed(by: disposeBag)

        tbView.rx.itemSelected.bind { indexPath in
            zlogger(message: indexPath.row.toString)
        }.disposed(by: disposeBag)
 */
    ///加载多个sections
        
        let ob = Observable.just([SectionModel(model: "Standard Items", items: [CellModel.standard("First Item"),
                                                                                CellModel.standard("Second Item")]),
                                  SectionModel(model: "Standard Items", items: [CellModel.important(Important(text: "Third item", imporance: 1)),
                                                                                CellModel.important(Important(text: "Four item", imporance: 100))])])
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, CellModel>>(configureCell: { datasource, table, indexPath, item in
            switch item {
            case .standard(let value):
                return self.makeCell(with: value, from: table)
            case .important(let important):
                return self.makeImportantCell(with: important, from: table)
            }
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].model
        }
        
        ob.bind(to: tbView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tbView.rx.itemSelected.bind { indexPath in
            zlogger(message: indexPath.row.toString)
        }.disposed(by: disposeBag)
        
    }
    
    private func makeCell(with element: String, from table: UITableView) -> UITableViewCell {
      let cell = table.dequeueReusableCell(withIdentifier: "Cell")!
      cell.textLabel!.text = element
      return cell
    }

    private func makeImportantCell(with element: Important, from table: UITableView) -> UITableViewCell {
      let cell = table.dequeueReusableCell(withIdentifier: "ImportantCell")!
      cell.textLabel!.text = element.text
      cell.textLabel!.textColor = .white
      return cell
    }

    
}

struct Important {
    let text: String
    
    let imporance: Int
}

enum CellModel {
    case standard(String)
    case important(Important)
}


//extension ViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = indexPath.row.toString
//        cell.textLabel?.textColor = .black
//        return cell
//    }
//}
//
//extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: false)
//    }
//
//}
