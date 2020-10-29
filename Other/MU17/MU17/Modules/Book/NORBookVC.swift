//
//  NORBookVC.swift
//  MU17
//
//  Created by nor on 2020/10/27.
//

import UIKit

class NORBookVC: NORBaseVC {

    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .grouped)
        tw.backgroundColor = .background
        tw.delegate = self
        tw.dataSource = self
        tw.register(cellType: UBaseTableViewCell.self)
        tw.backgroundColor = .red
        return tw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.usnp.edges).priority(.low)
            $0.top.equalToSuperview()
        }
    }
}

extension NORBookVC: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UBaseTableViewCell.self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}
