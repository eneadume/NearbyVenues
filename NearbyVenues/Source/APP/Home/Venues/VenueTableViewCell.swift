//
//  VenueTableViewCell.swift
//  NearbyVenues
//
//  Created by Enea Dume on 6/22/22.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = Color.Label.secondary
        return label
    }()
    
    static var reuseIdentifier: String {
        return "VenueTableViewCell"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func addSubviews() {
        addSubview(subtitleLabel)
        addSubview(titleLabel)
        addConstraints()
    }

    private func addConstraints() {
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))

        subtitleLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: bottomAnchor, trailing: titleLabel.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 16, right: 0))
    }
    
    func configure(for venue: Venue) {
        self.titleLabel.text = venue.name! ?? ""
        self.subtitleLabel.text = venue.location?.formattedAddress! ?? ""
    }
}
