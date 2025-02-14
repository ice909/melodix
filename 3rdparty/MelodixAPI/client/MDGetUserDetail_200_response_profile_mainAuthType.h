/**
 * MelodixAPI
 * Melodix API
 *
 * The version of the OpenAPI document: 1.0.0
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */

/*
 * MDGetUserDetail_200_response_profile_mainAuthType.h
 *
 * 
 */

#ifndef MDGetUserDetail_200_response_profile_mainAuthType_H
#define MDGetUserDetail_200_response_profile_mainAuthType_H

#include <QJsonObject>

#include <QList>
#include <QString>

#include "MDEnum.h"
#include "MDObject.h"

namespace MelodixAPI {

class MDGetUserDetail_200_response_profile_mainAuthType : public MDObject {
public:
    MDGetUserDetail_200_response_profile_mainAuthType();
    MDGetUserDetail_200_response_profile_mainAuthType(QString json);
    ~MDGetUserDetail_200_response_profile_mainAuthType() override;

    QString asJson() const override;
    QJsonObject asJsonObject() const override;
    void fromJsonObject(QJsonObject json) override;
    void fromJson(QString jsonString) override;

    qint32 getType() const;
    void setType(const qint32 &type);
    bool is_type_Set() const;
    bool is_type_Valid() const;

    QString getDesc() const;
    void setDesc(const QString &desc);
    bool is_desc_Set() const;
    bool is_desc_Valid() const;

    QList<QString> getTags() const;
    void setTags(const QList<QString> &tags);
    bool is_tags_Set() const;
    bool is_tags_Valid() const;

    virtual bool isSet() const override;
    virtual bool isValid() const override;

private:
    void initializeModel();

    qint32 m_type;
    bool m_type_isSet;
    bool m_type_isValid;

    QString m_desc;
    bool m_desc_isSet;
    bool m_desc_isValid;

    QList<QString> m_tags;
    bool m_tags_isSet;
    bool m_tags_isValid;
};

} // namespace MelodixAPI

Q_DECLARE_METATYPE(MelodixAPI::MDGetUserDetail_200_response_profile_mainAuthType)

#endif // MDGetUserDetail_200_response_profile_mainAuthType_H
