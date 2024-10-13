import UIKit

class NavAreaTableViewCell: UITableViewCell {
    
    let areaLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let iconImageView = UIImageView(image: UIImage(systemName: "location.fill"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.tintColor = .systemBlue
        
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        areaLabel.translatesAutoresizingMaskIntoConstraints = false
        areaLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        areaLabel.textColor = .label
        
        contentView.addSubview(areaLabel)
        
        NSLayoutConstraint.activate([
            areaLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            areaLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            areaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
       
    }
    
    func configure(with areaName: String) {
        areaLabel.text = areaName
    }
}
