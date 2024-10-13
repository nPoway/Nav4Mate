import UIKit

class WarningsTableViewCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, yearLabel, messageLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
       
        contentView.layer.cornerRadius = 8
    }
    
    func configure(with warning: Warning) {
        iconImageView.image = UIImage(systemName: "exclamationmark.triangle")
        
        var year = warning.year
        if year.count < 3 {
            year = "20\(year)"
        }
        titleLabel.text = warning.title
        yearLabel.text = "Year: \(year) - Number: \(warning.number)"
        messageLabel.text = warning.message
    }
}
