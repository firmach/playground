//
//  ViewController.swift
//
//  Created by Roman Churkin on 21/11/2018.
//

import UIKit


class ViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private var tableView: UITableView!
    
    
    // MARK: -
    // MARK: Properties
    
    private var card: CardView = CardView.loadFromNib()!
    private var sections: [Section] = []
    
    
    // MARK: -
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 22
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.estimatedSectionHeaderHeight = 56
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        configureTableBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        sections = Section.randomSections()
        tableView.reloadData()
        
        layoutTableContentView()
    }

    
    // MARK: -
    // MARK: Helpers
    
    private func configureTableBackgroundView() {
        card.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = #colorLiteral(red: 0.2196078431, green: 0.4666666667, blue: 0.5019607843, alpha: 1)
        backgroundView.addSubview(card)
        tableView.backgroundView = backgroundView
        
        NSLayoutConstraint.activate([
            card.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: CardViewConstants.defaultInset),
            card.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -CardViewConstants.defaultInset),
            card.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CardViewConstants.defaultInset)
            ])
    }
    
    private func layoutTableContentView() {
        let rawCardBottom = CGPoint(x: 0, y: card.frame.maxY)
        let cardBottom = tableView.backgroundView!.convert(rawCardBottom, to: tableView).y
        let topInset = cardBottom + CardViewConstants.defaultInset * 3
        
        tableView.contentInset =
            UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }

}


// MARK: -
// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let model = section.cells[indexPath.row]

        let lastSectionIndex = sections.count - 1
        let lastRowIndex = sections[lastSectionIndex].cells.count - 1

        var cell: UITableViewCell & TableViewPositionedView
        if let model = model as? SimpleModel {
            cell = prepareCell(for: model)
        } else if let model = model as? ComplexModel {
            cell = prepareCell(for: model)
        } else {
            preconditionFailure()
        }
        
        switch (indexPath.section, indexPath.row) {
        case (lastSectionIndex, lastRowIndex): cell.update(for: .bottom)
        default: cell.update(for: .middle)
        }
        
        return cell
    }
    
    private func prepareCell(for model: SimpleModel) -> UITableViewCell & TableViewPositionedView {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "SimpleCell") as! SimpleCell
        cell.configure(for: model.line,
                       max: tableView.bounds.width)
        return cell
    }
    
    private func prepareCell(for model: ComplexModel) -> UITableViewCell & TableViewPositionedView {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "ComplexCell") as! ComplexCell
        cell.configure(for: model.lines)
        return cell
    }
    

}


// MARK: -
// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView.loadFromNib()!
        headerView.configure(for: sections[section].headerWidth,
                             max: tableView.bounds.width)
        
        switch section {
        case 0: headerView.update(for: .top)
        default: headerView.update(for: .middle)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let room = (scrollView.bounds.height - scrollView.contentInset.top) * 0.25
        let position = view.safeAreaInsets.top + scrollView.contentInset.top + scrollView.contentOffset.y
        let progress = Float(-position / room)
        
        card.progress = Float.minimum(progress, 1.0)
    }
    
}
